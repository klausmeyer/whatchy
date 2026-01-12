# Disable https://github.com/rails/rails/pull/53281
module MonkeyPatches
  module DisableSortedColumnsInSchema
    def initialize(connection, options = {})
      super

      class << @connection
        alias_method :original_columns, :columns

        def columns(table)
          columns_array = original_columns(table)

          # Override sort_by to skip sorting
          def columns_array.sort_by(*) = self

          columns_array
        end
      end
    end
  end
end

if Rails.version.to_s == "8.1.2"
  ActiveRecord::SchemaDumper.prepend MonkeyPatches::DisableSortedColumnsInSchema
else
  warn "WARNING: It looks like Rails has been changed since `ActiveRecord::SchemaDumper` was monkey-patched in #{__FILE__}. Please re-evaluate the patch."
end
