package com.saravlabs.midnight.icons;

import android.app.Activity;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.WindowInsets;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

/** A permission-free gallery. Appearance is applied through the user's launcher. */
public final class IconPackActivity extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ScrollView scroll = new ScrollView(this);
        scroll.setBackgroundColor(0xff142136);
        scroll.setOnApplyWindowInsetsListener((view, insets) -> {
            android.graphics.Insets safe = insets.getInsets(
                    WindowInsets.Type.systemBars() | WindowInsets.Type.displayCutout());
            view.setPadding(safe.left, safe.top, safe.right, safe.bottom);
            return insets;
        });
        LinearLayout content = new LinearLayout(this);
        content.setOrientation(LinearLayout.VERTICAL);
        content.setPadding(dp(24), dp(24), dp(24), dp(24));
        scroll.addView(content);
        content.addView(text(R.string.app_name, 26));
        content.addView(text(R.string.intro, 16));
        content.addView(text(R.string.scope, 14));
        int[] icons = {R.drawable.assistant, R.drawable.browser, R.drawable.calendar,
                R.drawable.camera, R.drawable.files, R.drawable.mail, R.drawable.maps,
                R.drawable.messages, R.drawable.music, R.drawable.phone, R.drawable.photos,
                R.drawable.settings};
        int[] names = {R.string.assistant_icon, R.string.browser_icon, R.string.calendar_icon,
                R.string.camera_icon, R.string.files_icon, R.string.mail_icon, R.string.maps_icon,
                R.string.messages_icon, R.string.music_icon, R.string.phone_icon, R.string.photos_icon,
                R.string.settings_icon};
        for (int i = 0; i < icons.length; i++) {
            LinearLayout row = new LinearLayout(this);
            row.setGravity(Gravity.CENTER_VERTICAL);
            row.setPadding(0, dp(12), 0, dp(12));
            ImageView image = new ImageView(this);
            image.setImageResource(icons[i]);
            image.setImportantForAccessibility(View.IMPORTANT_FOR_ACCESSIBILITY_NO);
            row.addView(image, new LinearLayout.LayoutParams(dp(64), dp(64)));
            TextView name = text(names[i], 18);
            name.setPadding(dp(16), 0, 0, 0);
            row.addView(name);
            content.addView(row);
        }
        setContentView(scroll);
        scroll.requestApplyInsets();
    }

    private TextView text(int resource, int size) {
        TextView text = new TextView(this);
        text.setText(resource);
        text.setTextSize(size);
        text.setTextColor(0xffc9e1f7);
        text.setPadding(0, dp(8), 0, dp(8));
        return text;
    }

    private int dp(int value) {
        return Math.round(value * getResources().getDisplayMetrics().density);
    }
}
