require_relative "container"

module Berg
  Import = Berg::Container::Inject.args

  auto_inject = Dry::AutoInject(Berg::Container)

  HashImport = -> *keys do
    keys.each do |key|
      Berg::Container.load_component(key) unless Berg::Container.key?(key)
    end

    auto_inject.hash[*keys]
  end

  def self.Import(*args)
    Import[*args]
  end
end
