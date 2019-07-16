view: subtotal_over {
  sql_table_name: (select '' as row_type union select null as row_type) ;; #This sql table name is used to create a duplicate copy of the data. When rowType is null, fields from this view will resolve to 'SUBTOTAL'

  #used in sql parameters below to re-assign values to 'SUBTOTAL' on subtotal rows
  dimension: row_type_checker {
    hidden:yes
    sql: ${TABLE}.row_type ;;
  }
  # used for readability in sql_where of nested subtotal join
  dimension: row_type_description {
    hidden:yes
    sql:coalesce(${TABLE}.row_type,'SUBTOTAL');;
  }

#######################################
### Example String Based Dimensions ###
  dimension: status {
    order_by_field: status_order
    # For subtotal rows: show 'SUBTOTAL'.  For nulls, show '∅' (supports intuitive sorting).  Otherwise use raw base table field's data. Note, concatenation with '${row_type_checker}' is used to concisely force subtotal rows to evaluate to null, which is then converted to 'SUBTOTAL'
    sql: coalesce(cast(coalesce(cast(${orders.status} as char(50)),'∅')||${row_type_checker} as char(50)),'SUBTOTAL');;
  }
  dimension: status_order {
    hidden: yes
    #For order by fields, use a similar calculation, but use values that correctly put nulls at min and subtotals at max of sort order positioning
    sql: coalesce(cast(coalesce(cast(${orders.status} as char(50)),'AAAAAAAAAA')||${row_type_checker} as char(50)),'ZZZZZZZZZZ');;
  }

}
