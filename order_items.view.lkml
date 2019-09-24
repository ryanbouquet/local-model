view: order_items {
  sql_table_name: demo_db.order_items ;;

  parameter: testing {
    allowed_value: {value: "1"}
    allowed_value: {value: "2"}
  }

  dimension: test_liquid {
    type: number
    sql: {% if testing._parmaeter_value == '1' %} orders.id {% else %} products.id {% endif %} ;;
  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    description: "really long description for testing purposes to see if it gets cut off ok cool"
    #html: <div style="background-color:black;color: blue">
#{{rendered_value}}
#</div> ;;
  }

  measure: test_html {
    type:  average
    sql: ${id} ;;
    drill_fields: [id]
    html: {% if value < 3 %}
          <font color="darkgreen">{{ rendered_value }}</font>
          {% elsif value < 5 %}
          <font color="goldenrod">{{ rendered_value }}</font>
          {% else %}
          <font color="darkred">{{ rendered_value }}</font>
          {% endif %} ;;
  }

  dimension: zip {
    type: zipcode
    sql: "20852" ;;
  }

  dimension: product_id {
    type: number
    sql: ${products.id} ;;
  }
  dimension: 20_more {
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: test {
    sql: "test" ;;
    link: {
      label: "link"
      url: "{% if id._value == 1 %} https://google.com/{{ order_id._value }}/{{ inventory_item_id._value }}
      {% elsif id._value == 2 %} https://google2.com/{{ order_id._value }}/{{ inventory_item_id._value }}
      {% endif %}"
    }
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      month_name
    ]
    sql: ${TABLE}.returned_at ;;
  }

  set: ret_times {
    fields: [returned_raw,
      returned_time,
      returned_date,
      returned_week]
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: tier {
    type: tier
    sql: ${sale_price} ;;
    tiers: [1]
    style: integer
  }
  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
}
