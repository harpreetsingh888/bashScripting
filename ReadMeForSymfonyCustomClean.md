<h2>Symfony2 Custom Cleaning Script</h2>

This script can be useful to do all the Symfony stuff like cache clear, assets, assetic dump, clearing cached templated

Add this script to the base directory of your Symfony project.

Make the script executable by using: sudo chmod +x clean.sh

To get help for the script, run: sh clean.sh -help
which will show you the following:
usage sh clean.sh
-d Dumps assetic
-dw Dumps assetic and watch
-c Clear symfony ache
-t Remove cached templates
-a Dump assets

If you run sh clean.sh than the script will clear cache, install assests in /web, do assetic:dump and clear cached templated in libs/smarty/templates_c/ directory otherwise you can run the script to do one thing only.
