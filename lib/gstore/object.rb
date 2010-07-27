module GStore
  class Client
    def put_object(bucket, filename, options={})
      put(bucket, add_slash_if_needed(filename), options)
    end
    
    def get_object(bucket, filename, options={})
      outfile = options.delete(:outfile)
      res = get(bucket, add_slash_if_needed(filename), options)
      if outfile
        File.open(outfile, 'w') {|f| f.write(res) }
      else
        res
      end
    end
    
    def delete_object(bucket, filename, options={})
      delete(bucket, add_slash_if_needed(filename), options)
    end
    
    def get_object_metadata(bucket, filename, options={})
      head(bucket, add_slash_if_needed(filename), options)
    end

    # Add a starting / if one was not provided
    # And encode ? as it breaks the sending
    def add_slash_if_needed(filename)
      CGI::escape(filename[0..0] == '/' ? filename : "/#{filename}").gsub('%2F', '/')
    end
  end
end
