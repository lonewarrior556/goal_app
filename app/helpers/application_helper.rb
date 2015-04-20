module ApplicationHelper

  def authentic_form
    <<-HTML.html_safe
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML
  end

  def my_button_to(url, text, method='Post')
    <<-HTML.html_safe
      <form class="Button" action="#{url}" method="post">
        <input type="hidden" name="_method" value="#{method}">
        #{ authentic_form}
        <button>#{text}</button>
      </form>
    HTML
  end


end
