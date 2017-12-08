'use strict';

import 'bulma/css/bulma.css';
import './styles.css';
import './index.html';

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
