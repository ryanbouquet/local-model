connection: "thelook"

# include all the views
include: "*.view"

datagroup: local_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: local_model_default_datagroup



explore: derived_test {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
    #fields: [id, age, city, country, first_name, gender, last_name, state, zip]
  }
  join: derived_test {
    type:  left_outer
    sql_on:  ${orders.id} = ${derived_test.orders_id} ;;
    relationship:  one_to_one
  }
  join: subtotal_over {
    type: cross
    relationship: one_to_many
  }
}

explore: products {
  sql_always_where: ${products.retail_price} is not null;;
  always_filter: {
    filters:  {
      field: products.retail_price
      value: ">0"
    }
  }
  fields: [ALL_FIELDS*, -products.zip_hopefully]
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  view_name: users
}

explore: users_extend {
  extends: [users]
  view_name: users_extend

  join: users {
    sql_on: ${users.id} = ${users_extend.id};;
    relationship: one_to_one
  }
}

explore: users_nn {
  view_label: "users (simplified)"
}
