include: "users.view"
view: users_extend {
  extends: [users]

  derived_table: {
    sql: SELECT id, count(*)
         from demo_db.users
         group by id;;
  }

  measure: extra_m {
    type: count
  }
}
