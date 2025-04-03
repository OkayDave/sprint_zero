class Avo::Resources::StaticPage < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :title, as: :text
    field :requires_sign_in, as: :boolean
    field :content, as: :trix
    field :generate_content_on_create, as: :boolean
    field :prompt_id, as: :select, options: -> { AI::Prompt.all.map { |prompt| [ prompt.title, prompt.id ] } }
    field :prompt_additions, as: :text
  end
end
