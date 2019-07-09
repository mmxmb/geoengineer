########################################################################
# GithubClient exposes a set of API calls to fetch data from GitHub.
# The primary reason for centralizing them here is testing and stubbing.
########################################################################
class PostgresClient
  def self.database_setup(provider)
    PG.connect( host: provider.host, port: provider.port, dbname: provider.database, user: provider.username, 
                password: provider.password )
  end

  def self.database_names(provider)
    conn = self.database_setup(provider)
    rows = conn.exec("SELECT datname FROM pg_database")
    return rows.column_values(0)
  end

  def self.database_roles(provider)
    conn = self.database_setup(provider)
    rows = conn.exec("SELECT rolname FROM pg_roles")
    return rows.column_values(0)
  end

  def self.database_schemas(provider)
    conn = self.database_setup(provider)
    rows = conn.exec("SELECT schema_name FROM information_schema.schemata")
    return rows.column_values(0)
  end

  def self.database_extensions(provider)
    conn = self.database_setup(provider)
    rows = conn.exec("SELECT extname FROM pg_extension")
    return rows.column_values(0)
  end

end
