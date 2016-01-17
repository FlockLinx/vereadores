module ApplicationHelper

  def breadcrumb(&block)
    content_tag :ol, { :class => "breadcrumb", :itemprop => "breadcrumb" } do
      block.call
    end
  end

  def is_active?(filter, filter_tab)
    filter == filter_tab ? "active" : ""
  end
  
  def breadcrumb_item(name = nil, url = nil, html_options = {}, &block)
    if name or block
      html_options[:class] = "#{html_options[:class]} active" unless url
      content_tag :li, html_options do
        if block
          block.call name, url
        else
          url ? link_to(name, url) : name
        end
      end
    end
  end

  def alphabetical_list(list, options = {})
    tags = ""
    br = options.fetch(:br, false)
    selected_index = options.fetch(:index, "")
    puts selected_index
    list_grouped  = list.group_by{|u| u.name[0]}
  	('A'..'Z').to_a.each do |letter|
        label = if selected_index == letter
          "label label-default"
          elsif list_grouped[letter]
            "label label-primary"
          else
            ""
          end
        options = {class: "alphabetic-letter #{label}"}
        options[:href] = "?indice=#{letter}" if list_grouped[letter]
        tags += content_tag (list_grouped[letter] ? :a : :span), options do
          letter
        end
        if (letter == 'K' && br)
          tags += "<br/>"
        end
    end
    tags.html_safe
  end

  def alphabetical_order(list, field = "name", &block)
    list.group_by{|u| u[field][0]}.each do |key, value|
      concat (content_tag :ul, class: "list-unstyled" do
        concat (content_tag :a, {name: key, class:"alphabetic-index"} do
          key
        end)
        value.each do |object|
          block.call object
        end
      end)
    end
  end

end
