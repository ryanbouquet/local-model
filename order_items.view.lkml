view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    description: "really long description for testing purposes to see if it gets cut off ok cool"
    html: <div style="background-color:black;color: blue">
{{rendered_value}}
</div> ;;
  }

  dimension: 20_more {
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: test {
    sql: "test" ;;
    link: {
      label: "link"
      url: "google.com"
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
      year
    ]
    sql: ${TABLE}.returned_at ;;
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
