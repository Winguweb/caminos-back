class CreateAgreement
  prepend Service::Base

  def initialize(neighborhood, params)
    @neighborhood = neighborhood
    @params = params
  end

  def call
    create_agreement
  end

  private

  def create_agreement

    @agreement = Agreement.new(data: agreement_params)
    @agreement.neighborhood = @neighborhood
    
    return @agreement if @agreement.save
    errors.add_multiple_errors(@agreement.errors.messages) && nil

  end

  def agreement_params
    @data = {}
    @params.keys.each do |indicator|
      @answers = {}
      @params[indicator][:questions].keys.each do |question|
        @answers[question.parameterize.underscore.to_sym] = @params[indicator][:questions][question.parameterize.underscore.to_sym]
      end
      @data[indicator.parameterize.underscore.to_sym] = { answers:  @answers, score:  @params[indicator][:score]}
    end
    return @data
  end
end
