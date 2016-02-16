module Jekyll

  class JsonPage < Page
  def initialize(site, data, tags, name) 
    @data = site.data.sgpm
    @tags = site.data.sgpm.Keywords
    @name = @data
    page.tags = @tags
  end
end

=begin
    def initialize(site, base, dir, data, name)
      @site = site
      @base = base
      @dir = dir
      @name = data[name].to_s + "." + extension.to_s

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'sgpm.html')
      self.data['title'] = data[name]

    end
  end

  class JsonGen < Generator
    safe true

    def generate(site)
      data = site.config['json_gen']
      if site.layouts.key? 'sgpm'
        records =  site.data[data_spec['data']]
            records.each do |record|
              site.pages << jsonPage.new(site, site.source, dir, record, name, template, extension)
            end
        end
      end
    end
  end
  =end
  