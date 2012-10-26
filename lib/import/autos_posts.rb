require 'mysql'

class AutosPostsImporter
  class << self
    RESULT_FILENAME = 'db/seed/cars_posts.yml'
    DB_HOST = '91.219.194.7'
    DB_NAME = 'intern_bortovik'
    DB_USER = 'intern_readonly'
    DB_PASSWORD = 'changeme'

    def execute
      @result = get_tree
      save
    end

    private
    def get_tree
      get_all_categories.map do |category|
        category['posts'] = get_category_posts(category['id'])
        category.delete('id')
        category
      end
    end

    def get_category_posts(category_id)
      query = "
        SELECT
          p.post_title AS name,
          p.post_content AS content,
          p.post_name AS slug
        FROM wp_posts p
        LEFT JOIN wp_term_relationships tr ON (tr.object_id=p.ID)
        WHERE tr.term_taxonomy_id=#{category_id}
        AND p.post_type='post'
      "
      get_hash_from_database(query)
    end

    def get_all_categories
      category_slugs = "'bmw', 'vaz', 'opel', 'ford', 'daewoo', 'renault', 'chevrolet', 'toyota'"
      query = "
        SELECT
          tx.term_taxonomy_id AS id,
          t.name,
          t.slug,
          tx.description AS content
        FROM wp_terms t
        LEFT JOIN wp_term_taxonomy tx ON (t.term_id=tx.term_id)
        WHERE tx.taxonomy='category'
        AND t.slug IN (#{category_slugs})
      "
      get_hash_from_database(query)
    end

    def get_hash_from_database(query)
      result = database.query query
      array = []
      result.each_hash do |hash|
        array << clean_hash(hash)
      end
      array
    end

    def clean_hash(hash)
      new_hash = hash.map do |key, value|
        [
          key.encode('UTF-8', 'Windows-1251'),
          value.encode('UTF-8', 'Windows-1251')
        ]
      end
      Hash[new_hash]
    end

    def database
      @database ||= Mysql.new(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME)
    end

    def save
      File.open(RESULT_FILENAME, "w") do |f|
        f.write(@result.to_yaml)
      end
    end
  end
end
