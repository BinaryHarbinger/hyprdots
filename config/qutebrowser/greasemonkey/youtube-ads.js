// ==UserScript==
// @name         YouTube Ad-Blocker (uBlock layout)
// @version      2.7
// @description  Hides ads and bypasses the 'adblock detected' popup
// @author       Communist (Fedora-user) 
// @match        https://www.youtube.com/*
// @grant        none
// @run-at       document-start
// @updateURL    https://codeberg.org/Huegochrome/RiverWM-Fedora-Minimal/raw/branch/main/config/qutebrowser/greasemonkey/ytuser.js
// @downloadURL  https://codeberg.org/Huegochrome/RiverWM-Fedora-Minimal/raw/branch/main/config/qutebrowser/greasemonkey/ytuser.js
// ==/UserScript==

(function() {
    const css = `
        ytd-ad-slot-renderer, 
        ytd-pyv-ad-renderer, 
        ytd-promoted-sparkles-web-renderer, 
        .ytd-item-section-renderer:has(ytd-ad-slot-renderer),
        ytd-rich-item-renderer:has(ytd-ad-slot-renderer),
        #masthead-ad, 
        .video-ads, 
        .ytp-ad-module, 
        tp-yt-paper-dialog:has(#enforcement-message) { 
            display: none !important; 
        }
    `;
    const style = document.createElement('style');
    style.appendChild(document.createTextNode(css));
    
    const checkAndAppend = () => {
        const target = document.head || document.documentElement;
        if (target) {
            target.appendChild(style);
        } else {
            requestAnimationFrame(checkAndAppend);
        }
    };
    checkAndAppend();

    // VIDEO AD SKIPPING
    setInterval(() => {
        const video = document.querySelector('video');
        const ad = document.querySelector('.ad-showing, .ad-interrupting');
        if (ad && video) {
            video.currentTime = video.duration;
            document.querySelectorAll('[class*="skip-button"]').forEach(btn => btn.click());
        }
    }, 100);

    // VERSION LOG
    console.log("%c YouTube Ad-Blocker Updated! %c Version 2.7 is now active.", 
                "color: white; background: #cc0000; font-weight: bold; border-radius: 5px; padding: 2px 5px;", 
                "color: #cc0000; font-weight: bold;");
})();
