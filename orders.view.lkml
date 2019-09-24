view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html: {{ value }} {{ user_id._value }} ;;
  }

  dimension: test_in {
    type:  yesno
    sql: ${user_id} IN (1,2,3) ;;
  }
  dimension: test_format {
    type: number
    sql: "2722";;
    value_format: "[>=1000000]0.00,,\"M\";[>=10000]0.00,,\"K\";#,##0"
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
    case: {
      when: {
        label: "cancelled"
        sql: ${TABLE}.status = "cancelled";;
      }
      when: {
        label: "complete"
        sql: ${TABLE}.status = "complete";;
      }
      when: {
        label: "pending"
        sql: ${TABLE}.status = "pending";;
      }
      when: {
        label: "total"
        sql: 1=1;;
      }
    }
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
