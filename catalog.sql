SELECT 
    e.entity_id,
    e.sku,
    (SELECT 
            value
        FROM
            c0preproddispo.dpx_catalog_product_entity_varchar AS `e_var_titre`
        WHERE
            `e_var_titre`.`entity_id` = `e`.`entity_id`
                AND `e_var_titre`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'name'
                        AND entity_type_id = 4)) AS name,
    (SELECT 
            CONCAT('/', value, '.html')
        FROM
            c0preproddispo.dpx_catalog_product_entity_varchar AS `e_var_url`
        WHERE
            `e_var_url`.`entity_id` = `e`.`entity_id`
                AND `e_var_url`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    c0preproddispo.dpx_eav_attribute AS `ea`
                WHERE
                    attribute_code = 'url_key'
                        AND `entity_type_id` = 4)
                AND `e_var_url`.store_id = 0) AS url,
    (SELECT 
            e_dec_price.value
        FROM
            `c0preproddispo`.`dpx_catalog_product_entity_decimal` AS `e_dec_price`
        WHERE
            `e_dec_price`.`entity_id` = `e`.`entity_id`
                AND `e_dec_price`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'price'
                        AND entity_type_id = 4)) AS 'price',
    (SELECT 
            `e_dec_spec_price`.value
        FROM
            `c0preproddispo`.`dpx_catalog_product_entity_decimal` AS `e_dec_spec_price`
        WHERE
            `e_dec_spec_price`.`entity_id` = `e`.`entity_id`
                AND `e_dec_spec_price`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'special_price'
                        AND entity_type_id = 4)) AS 'special_price',
    (SELECT 
            IF(`e_dec_status`.value = 1,
                    'actif',
                    'inactif')
        FROM
            `c0preproddispo`.`dpx_catalog_product_entity_int` AS `e_dec_status`
        WHERE
            `e_dec_status`.`entity_id` = `e`.`entity_id`
                AND `e_dec_status`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'status'
                        AND entity_type_id = 4)) AS 'status',
    (SELECT 
            CONCAT('https://www.xxxxxxxx.com/catalog/product',
                        e_var_image.value)
        FROM
            `c0preproddispo`.`dpx_catalog_product_entity_varchar` AS `e_var_image`
        WHERE
            `e_var_image`.`entity_id` = `e`.`entity_id`
                AND `e_var_image`.`store_id` = 0
                AND `e_var_image`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'image'
                        AND entity_type_id = 4)) AS image,
    (SELECT 
            GROUP_CONCAT(CONCAT('http://www.xxxxxxxx.com/catalog/product',
                            e_mg_gallery.value))
        FROM
            `c0preproddispo`.`dpx_catalog_product_entity_media_gallery` AS `e_mg_gallery`
                LEFT JOIN
            `c0preproddispo`.`dpx_catalog_product_entity_media_gallery_value_to_entity` AS `e_mg_gallery_ve` ON `e_mg_gallery_ve`.`value_id` = `e_mg_gallery`.`value_id`
        WHERE
            `e_mg_gallery_ve`.`entity_id` = `e`.`entity_id`
                AND `e_mg_gallery`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'media_gallery'
                        AND entity_type_id = 4)
        GROUP BY `e_mg_gallery_ve`.`entity_id`) AS images_supp,
    e.type_id AS 'type',
    (SELECT 
            `e_dec_desription`.value
        FROM
            `c0preproddispo`.`dpx_catalog_product_entity_text` AS `e_dec_desription`
        WHERE
            `e_dec_desription`.`entity_id` = `e`.`entity_id`
                AND `e_dec_desription`.attribute_id IN (SELECT 
                    attribute_id
                FROM
                    `c0preproddispo`.`dpx_eav_attribute`
                WHERE
                    `attribute_code` = 'description'
                        AND entity_type_id = 4)) AS 'description',
    e.created_at,
    e.updated_at
FROM
    `c0preproddispo`.`dpx_catalog_product_entity` AS `e`
        LEFT JOIN
    `c0preproddispo`.`dpx_catalog_product_entity_int` AS `e_int_status` ON (`e_int_status`.`entity_id` = `e`.`entity_id`
        AND `e_int_status`.attribute_id IN (SELECT 
            attribute_id
        FROM
            `c0preproddispo`.`dpx_eav_attribute`
        WHERE
            `attribute_code` = 'status'))
