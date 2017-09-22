package com.incra.ratpack;

import ratpack.handling.Context;
import ratpack.handling.Handler;

/**
 * @author Jeff Risberg
 * @since 12/14/16
 */
public class UpdateHandler implements Handler {

    public UpdateHandler() {
    }

    @Override
    public void handle(Context context) {
        context.render("Update handler");
    }
}
