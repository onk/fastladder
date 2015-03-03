if Rails.env.development?
  task :set_annotation_options do
    Annotate.set_defaults({
      position_in_class: :before,
      show_indexes:      true,
      exclude_tests:     true,
      exclude_fixtures:  true,
      exclude_factories: true,
      format_bare:       true,
    })
  end

  Annotate.load_tasks
end
