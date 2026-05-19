package com.gayatri.member.association.restaurent.mapper;

import com.gayatri.member.association.entity.restaurent.Item;
import com.gayatri.member.association.entity.restaurent.SubItem;
import com.gayatri.member.association.restaurent.dto.RestaurantSubItemDTO;

public class RestaurantSubItemMapper {

    public static RestaurantSubItemDTO toDto(SubItem entity) {
        RestaurantSubItemDTO dto = new RestaurantSubItemDTO();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
        dto.setPrice(entity.getPrice());
        dto.setStatus(entity.getStatus());

        Item item = entity.getItem();
        if (item != null) {
            dto.setItemId(item.getId());
            dto.setItemName(item.getName());
        }

        return dto;
    }

    public static SubItem toEntity(RestaurantSubItemDTO dto, Item item) {
        SubItem entity = new SubItem();
        entity.setId(dto.getId());
        entity.setName(dto.getName());
        entity.setPrice(dto.getPrice());
        entity.setStatus(dto.getStatus());
        entity.setItem(item);
        return entity;
    }

    public static void updateEntity(SubItem entity, RestaurantSubItemDTO dto, Item item) {
        entity.setName(dto.getName());
        entity.setPrice(dto.getPrice());
        entity.setStatus(dto.getStatus());
        entity.setItem(item);
    }
}
