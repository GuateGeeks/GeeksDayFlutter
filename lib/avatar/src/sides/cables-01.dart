import 'package:flutter/painting.dart';

String cables01Side(Color color) => '''
        <g opacity="0.9">
            <path id="Cable" d="M38 12C35.046 23.6966 18.0959 18.6663 14.6313 30.009C11.1668 41.3518 22.6565 50 32.1552 50" stroke="#2A3544" stroke-width="6"/>
            <path id="Cable_2" d="M150 55C158.394 58.4864 170.102 47.4063 166 38.5C161.898 29.5936 150 31.8056 150 19.195" stroke="#2A3544" stroke-width="4"/>
        </g>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M138 6C136.895 6 136 6.89543 136 8V22C136 23.1046 136.895 24 138 24H157C158.105 24 159 23.1046 159 22V8C159 6.89543 158.105 6 157 6H138ZM21 37C21 35.8954 21.8954 35 23 35H35C36.1046 35 37 35.8954 37 37V55C37 56.1046 36.1046 57 35 57H23C21.8954 57 21 56.1046 21 55V37ZM136 44C136 42.8954 136.895 42 138 42H157C158.105 42 159 42.8954 159 44V62C159 63.1046 158.105 64 157 64H138C136.895 64 136 63.1046 136 62V44Z" fill="#273951"/>
        <mask id="sidesCables01Mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="21" y="6" width="138" height="58">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M138 6C136.895 6 136 6.89543 136 8V22C136 23.1046 136.895 24 138 24H157C158.105 24 159 23.1046 159 22V8C159 6.89543 158.105 6 157 6H138ZM21 37C21 35.8954 21.8954 35 23 35H35C36.1046 35 37 35.8954 37 37V55C37 56.1046 36.1046 57 35 57H23C21.8954 57 21 56.1046 21 55V37ZM136 44C136 42.8954 136.895 42 138 42H157C158.105 42 159 42.8954 159 44V62C159 63.1046 158.105 64 157 64H138C136.895 64 136 63.1046 136 62V44Z" fill="white"/>
        </mask>
        <g mask="url(#sidesCables01Mask0)">
            <rect width="180" height="76" fill="rgb(${color.red}, ${color.green}, ${color.blue})"/>
        </g>
    ''';
