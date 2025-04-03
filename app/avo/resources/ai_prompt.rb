class Avo::Resources::AIPrompt < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  self.model_class = ::AI::Prompt
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :title, as: :text
    field :content, as: :trix
    field :response_format, as: :textarea
    field :additional_options, as: :textarea
  end
end
