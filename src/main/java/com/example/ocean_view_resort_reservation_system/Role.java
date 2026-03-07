package com.oceanview.model;

public enum Role {
    STAFF("Staff"),
    ADMIN("Admin");

    private final String displayName;

    Role(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    // Helper to convert String from DB/Form to Enum safely
    public static Role fromString(String text) {
        for (Role r : Role.values()) {
            if (r.displayName.equalsIgnoreCase(text)) {
                return r;
            }
        }
        return STAFF; // Default role
    }
}