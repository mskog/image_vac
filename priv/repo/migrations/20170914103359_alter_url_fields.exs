defmodule ImageVac.Repo.Migrations.AlterUrlFields do
  use Ecto.Migration

  def change do
    alter table("vacs") do
      modify :url, :text
    end

    alter table("images") do
      modify :url, :text
    end
  end
end
