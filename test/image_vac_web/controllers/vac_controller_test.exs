defmodule Discuss.VacControllerTest do
  use ImageVacWeb.ConnCase, async: true

  describe "index/2" do
    test "Gives 200 ok" do

      response = build_conn()
      |> get(vac_path(build_conn(), :index))

      assert html_response(response, 200) =~ "Vacs"
    end
  end
end
