%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "web/", "apps/"],
        excluded: []
      },
      checks: [
        # I love this override
        {Credo.Check.Design.AliasUsage, if_nested_deeper_than: 2},
      ]
    }
  ]
}
