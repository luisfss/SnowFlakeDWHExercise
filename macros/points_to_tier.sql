{% macro points_to_tier(points_col) %}
    {#
        points_to_tier
        --------------
        Classifies a driver's season points total into a performance tier.
        Centralises the threshold logic so it only lives in one place.

        Usage:
            {{ points_to_tier('total_points') }} as performance_tier
    #}
    case
        when {{ points_col }} >= 400 then 'Championship Contender'
        when {{ points_col }} >= 200 then 'Race Winner'
        when {{ points_col }} >= 100 then 'Points Scorer'
        when {{ points_col }} >= 1   then 'Backmarker'
        else                              'No Points'
    end
{% endmacro %}
