view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      day_of_week_index
    ]
    drill_fields: [count]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_date_test {
    type: date
    drill_fields: [created_date, check_id_match]
    sql: ${created_date} ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  measure: check_id_match {
    type:  number
    sql: ${users.id} - ${orders.user_id} ;;
    description: "should be 0 everytime"
  }
}
