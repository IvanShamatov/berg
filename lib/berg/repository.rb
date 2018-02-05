require "rom-repository"
require "berg/container"
require "berg/import"

Berg::Container.start(:persistence)

module Berg
  class Repository < ROM::Repository::Root
    # This .new shouldn't be needed, since repos should work with dry-
    # auto_inject. This is not working yet, so this remains as a workaround.
    def self.new(rom = nil)
      super(rom || Berg::Container["persistence.rom"])
    end
  end
end
