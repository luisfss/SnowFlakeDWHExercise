{% macro limit_dev(n=100) %}
    {#
        limit_dev
        ---------
        Appends a LIMIT clause in dev environments so exploratory runs
        are fast without changing the model logic. In prod, returns nothing.

        Usage:
            select * from my_large_table
            {{ limit_dev(500) }}
    #}
    {% if target.name == 'dev' %}
        limit {{ n }}
    {% endif %}
{% endmacro %}
