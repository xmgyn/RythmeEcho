/* @refresh reload */
import { render } from 'solid-js/web';
import { Router, Route } from "@solidjs/router";

import './index.css';

import Play from './routes/Play'
import All from "./routes/All";
import History from "./routes/History";
import Home from "./routes/Home";

const root = document.getElementById('root');

if (import.meta.env.DEV && !(root instanceof HTMLElement)) {
  throw new Error(
    'Root element not found. Did you forget to add it to your index.html? Or maybe the id attribute got misspelled?',
  );
}

render(() => (
  <Router root={Home}>
    <Route path="/play" component={<Play />} />
    <Route path="/all" component={<All />} />
    <Route path="/history" component={<History />} />
    {/* <Route path="*404" component={NotFound} /> */}
  </Router>
), root);