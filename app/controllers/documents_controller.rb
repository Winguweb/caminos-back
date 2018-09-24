class DocumentsController < ApplicationController
  include CurrentAndEnsureDependencyLoader
  helper_method :current_neighborhood

  before_action :check_for_mobile, :only => %i[index]

  helper_method :current_documentable

  def index
    load_documents
  end

  private

  def current_documentable
    return @current_documentable if defined? @current_documentable

    @current_documentable = current_neighborhood || current_work

    (redirect_back(fallback_location: root_path) and return) unless @current_documentable

    @current_documentable
  end

  def load_documents
    @documents = current_documentable.documents.reverse
  end
end
