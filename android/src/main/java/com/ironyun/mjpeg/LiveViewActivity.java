package com.ironyun.mjpeg;

import android.app.Activity;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.MenuItem;

import com.github.niqdev.mjpeg.DisplayMode;
import com.github.niqdev.mjpeg.Mjpeg;
import com.github.niqdev.mjpeg.MjpegInputStream;
import com.github.niqdev.mjpeg.MjpegView;

import rx.functions.Action1;

public class LiveViewActivity extends Activity {
    private MjpegView mjpegView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        getActionBar().setDisplayHomeAsUpEnabled(true);
        setTitle("Live view");

        String url = getIntent().getStringExtra("url");

        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        setContentView(R.layout.mjpeg_layout);
        mjpegView = findViewById(R.id.mjpegViewDefault);

        Mjpeg.newInstance().open(url).subscribe(new Action1<MjpegInputStream>() {
            @Override
            public void call(MjpegInputStream s) {
                mjpegView.setSource(s);
                mjpegView.setDisplayMode(DisplayMode.BEST_FIT);

            }
        });
    }

    public boolean onOptionsItemSelected(MenuItem item){
        int id = item.getItemId();

        if (id==android.R.id.home) {
            finish();
        }

        return true;
    }

    @Override
    protected void onPause() {
        super.onPause();

        Log.d("MJPG", "pause");
        mjpegView.stopPlayback();
    }

}
