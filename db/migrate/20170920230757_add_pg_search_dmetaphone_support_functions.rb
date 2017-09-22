class AddPgSearchDmetaphoneSupportFunctions < ActiveRecord::Migration[5.0]
  def self.up
    enable_extension 'pg_trgm'
    enable_extension 'unaccent'
  end

  def self.down
    disable_extension 'pg_trgm'
    disable_extension 'unaccent'
  end
end
