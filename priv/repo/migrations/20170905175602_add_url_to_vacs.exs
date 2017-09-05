defmodule ImageVac.Repo.Migrations.AddUrlToVacs do
  use Ecto.Migration

  def change do
    alter table(:vacs) do
      add :url, :string
    end
  end
end
