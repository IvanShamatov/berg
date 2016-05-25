module Persistence
  module Relations
    class People < ROM::Relation[:sql]
      schema(:people) do
        attribute :id, Types::Serial
        attribute :first_name, Types::Strict::String
        attribute :last_name, Types::Strict::String
        attribute :email, Types::Strict::String
        attribute :twitter, Types::Strict::String
        attribute :bio, Types::Strict::String
        attribute :website, Types::Strict::String
        attribute :avatar, Types::Strict::String
        attribute :job_title, Types::Strict::String
        attribute :active, Types::Strict::Bool
      end

      use :pagination
      per_page 20

      def by_id(id)
        where(id: id)
      end

      def active
        where(active: true)
      end

      def about_page_people
        select
          .inner_join(
            :about_page_people,
            person_id: :id)
          .where(active: true)
          .order(:position)
      end
    end
  end
end
