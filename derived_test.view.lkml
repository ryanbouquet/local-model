view: derived_test {
  derived_table: {
    sql: SELECT *
         FROM demo_db.orders  AS orders
      ;;
  }

dimension: orders_id {
  type: number
  sql: ${TABLE}.id ;;
}

  measure: count_id {
    type: count
  }
}
