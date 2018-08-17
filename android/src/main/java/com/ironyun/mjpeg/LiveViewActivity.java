package com.ironyun.mjpeg;

import android.app.Activity;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.MenuItem;
import android.widget.Toast;

import com.github.niqdev.mjpeg.DisplayMode;
import com.github.niqdev.mjpeg.Mjpeg;
import com.github.niqdev.mjpeg.MjpegInputStream;
import com.github.niqdev.mjpeg.MjpegView;

import rx.Subscriber;
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


        Mjpeg.newInstance().open(url).subscribe(new Subscriber<MjpegInputStream>() {
            @Override
            public void onCompleted() {
                Log.d("MJPG", "subscribe completed");

            }

            @Override
            public void onError(Throwable throwable) {
                Log.d("MJPG", "subscribe error");
                Toast.makeText(LiveViewActivity.this, "Cannot open live view URL",
                        Toast.LENGTH_LONG).show();
            }

            @Override
            public void onNext(MjpegInputStream s) {
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
