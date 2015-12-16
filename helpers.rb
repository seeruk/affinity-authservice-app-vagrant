require "yaml"


class ConfigHelper
  # Gets the configuration (with local override if available) as a hash, from
  # the given YAML file(s).
  # ++
  # Returns a hash of a config
  def self.getConfig(distFile, localFile)
    dist  = YAML::load(File.open(distFile))
    local = {}

    if File.file?(localFile)
      local = YAML::load(File.open(localFile))
    end

    return HashHelper::deepMerge(dist, local)
  end
end


class HashHelper
  # Deep merge a hash with another hash
  # ++
  # Returns the merged hash
  def self.deepMerge(hash1, hash2)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    result = hash1.merge(hash2, &merger)

    return result;
  end
end
