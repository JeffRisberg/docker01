package com.incra.ratpack;

import java.util.Arrays;
import java.util.List;

/**
 * @author Jeff Risberg
 * @since 12/20/16
 */
public class DefaultUserService implements UserService {
    public List<String> getUsers() {
        String[] users = {"John", "Paul", "George", "Ringo"};

        return Arrays.asList(users);
    }
}
