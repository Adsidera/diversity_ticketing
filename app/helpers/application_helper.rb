module ApplicationHelper
  def navbar_link_to(name, url)
    link_to_unless_current(name, url) {
      content_tag(:span, name, class: 'active')
    }
  end

  def span_for_funded(title, funded)
    content_tag(:span, title, class: funded ? 'funded' : 'not-funded')
  end

  def join_messages(messages)
    *head, tail = messages
    [head.join(", "), tail].reject { |s| s.blank? }.join(" and ")
  end

  def pluralize_highlight_count(count, word)

    output = Array.new
    output << "<span class='highlight'>#{count}</span>"

    if count != 0
      count == 1 ? output << "#{word}" : output << "#{word.pluralize}"
    end

    output.join(' ').html_safe
  end
end
