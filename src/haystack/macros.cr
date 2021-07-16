class Haystack
  macro time_field(*fields)
    {% for field in fields %}
      @{{ field.id.downcase }}_at : Time?
      @{{ field.id.downcase }}At : Time?

      def {{ field.id.downcase }}_at : Time?
        @{{ field.id.downcase }}_at || @{{ field.id.downcase }}At
      end
    {% end %}
  end
end
