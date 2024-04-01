package com.dealim.util;

import java.lang.reflect.Field;

public class CopyBeanUtil {
    public static void copyNonNullProperties(Object source, Object target) throws IllegalAccessException {
        Class<?> sourceClass = source.getClass();
        Class<?> targetClass = target.getClass();

        Field[] fields = sourceClass.getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true); // private 필드에 접근 가능하도록 설정
            Object value = field.get(source);

            Field targetField;
            try {
                targetField = targetClass.getDeclaredField(field.getName());
            } catch (NoSuchFieldException e) {
                continue; // 대상 객체에 해당 필드가 없으면 다음으로 넘어갑니다.
            }

            targetField.setAccessible(true);
            Object targetValue = targetField.get(target);

            // 대상 객체의 필드 값이 null이고, 소스 객체의 해당 필드 값이 null이 아닌 경우에만 값을 복사합니다.
            if (targetValue == null && value != null) {
                targetField.set(target, value);
            }
        }
    }
}
