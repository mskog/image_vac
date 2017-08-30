defmodule ImageVac.Repo.Migrations.CreateVacs do
  use Ecto.Migration

  def change do
    create table(:vacs) do
      add :hash_id, :string
      timestamps()
    end

  end
end
