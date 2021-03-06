defmodule CountriesMirsTest do
  use ExUnit.Case, async: true

  test "filter countries by alpha2" do
    country = CountriesMirs.filter_by(:alpha2, "DE")
    assert Enum.count(country) == 1
  end

  test "filter countries by name" do
    countries = CountriesMirs.filter_by(:name, "United Kingdom of Great Britain and Northern Ireland")
    assert Enum.count(countries) == 1
  end

  test "filter countries by alternative names" do
    assert [_] = CountriesMirs.filter_by(:unofficial_names, "Reino Unido")

    assert [_] = CountriesMirs.filter_by(:unofficial_names, "The United Kingdom")
  end

  test "get one country" do
    %{alpha2: "GB"} = CountriesMirs.get("GB")
  end

  test "filter many countries by region" do
    countries = CountriesMirs.filter_by(:region, "Europe")
    assert Enum.count(countries) == 51
  end

  test "return empty list when there are no results" do
    countries = CountriesMirs.filter_by(:region, "Azeroth")
    assert countries == []
  end

  test "get all countries" do
    countries = CountriesMirs.all()
    assert Enum.count(countries) == 250
  end

  test "get country subdivisions" do
    country = List.first(CountriesMirs.filter_by(:alpha2, "BR"))
    assert Enum.count(CountriesMirs.Subdivisions.all(country)) == 27

    country = List.first(CountriesMirs.filter_by(:alpha2, "AD"))
    assert Enum.count(CountriesMirs.Subdivisions.all(country)) == 7

    country = List.first(CountriesMirs.filter_by(:alpha2, "AI"))
    assert Enum.count(CountriesMirs.Subdivisions.all(country)) == 14
  end

  test "checks if country exists" do
    country_exists = CountriesMirs.exists?(:name, "Poland")
    assert country_exists == true

    country_exists = CountriesMirs.exists?(:name, "Polande")
    assert country_exists == false
  end
end
