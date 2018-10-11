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
    @agreement = @neighborhood.agreement || Agreement.new
    @agreement.assign_attributes(data: agreement_params)
    @agreement.neighborhood = @neighborhood

    return @agreement if @agreement.save
    errors.add_multiple_errors(@agreement.errors.messages) && nil
  end

  def agreement_params
    indicators = Agreement.indicators

    @data = {}
    @params.keys.each do |indicator|
      score = 0
      @answers = {}
      @params[indicator][:questions].keys.each do |question|
        @answers[question.parameterize.underscore.to_sym] = @params[indicator][:questions][question.parameterize.underscore.to_sym]
      end

      @answers.each do |question, answer|
        score += indicators[indicator][:questions][question][:answers].select{|test_answer| test_answer[:text] == answer}.first[:weight].round(0)
      end

      @data[indicator.parameterize.underscore.to_sym] = { answers:  @answers, score: score}
    end
    return @data.to_json
  end
end
