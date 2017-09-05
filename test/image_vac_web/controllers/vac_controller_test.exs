defmodule Discuss.VacControllerTest do
  use ImageVacWeb.ConnCase, async: true

  describe "index/2" do
    test "Gives 200 ok" do

      response = build_conn()
      |> get(vac_path(build_conn(), :index, url: "http://www.example.com"))

      assert html_response(response, 200)
    end
  end
end
