view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: zip_hopefully {
    type:  zipcode
    sql: ${products.id} + 10000 ;;
  }

  dimension: bool_starts_with_A {
    type:  yesno
    sql:  UPPER(${brand_starts_with_A}) = 'A';;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: brand_starts_with_A {
    case: {
      when: {
        sql: LEFT(${products.brand}, 1) = 'A' ;;
        label: "A"
      }
      else: "NOT A"
    }
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: rank_tiers {
    type:  tier
    tiers: [0, 100, 10000, 1000000, 2000000]
    style: integer
    sql: ${TABLE}.rank ;;
  }
  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }

  measure: average_rank {
    type: average
    sql: ${rank} ;;
    value_format_name: decimal_0
  }

  measure: retail_sum_greater_than_100 {
    type:  sum
    sql: ${retail_price} ;;
    filters: {
      field: retail_price
      value: ">100"
    }
    value_format_name: decimal_0
    description: "sum of all retail prices greater than 100"
  }
}
