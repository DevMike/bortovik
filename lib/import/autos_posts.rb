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
        category[:posts] = get_category_posts(category[:id])
        category.to_hash
      end
    end

    def get_category_posts(category_id)
      query = "
        SELECT
          p.post_title AS title,
          p.post_content AS content,
          p.post_name AS slug
        FROM wp_posts p
        LEFT JOIN wp_term_relationships tr ON (tr.object_id=p.ID)
        WHERE tr.term_taxonomy_id=#{category_id}
        AND p.post_type='post'
      "
      result = database.query query
      posts = []
      result.each_hash do |post|
        posts << clean_hash(post)
      end
      posts
    end

    def get_all_categories
      category_slugs = "'bmw', 'vaz', 'opel', 'ford', 'daewoo', 'renault', 'chevrolet', 'toyota'"
      query = "
        SELECT
          tx.term_taxonomy_id AS id,
          t.name,
          t.slug,
          tx.description
        FROM wp_terms t
        LEFT JOIN wp_term_taxonomy tx ON (t.term_id=tx.term_id)
        WHERE tx.taxonomy='category'
        AND t.slug IN (#{category_slugs})
      "
      result = database.query query
      categories = []
      result.each_hash do |category|
        categories << clean_hash(category)
      end
      categories
    end

    def clean_hash(hash)
      new_hash = {}
      hash.each_pair do |key, value|
        new_key = key.encode('UTF-8', 'Windows-1251').to_sym
        new_value = value.encode('UTF-8', 'Windows-1251')
        new_hash[new_key] = new_value
      end
      new_hash
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
