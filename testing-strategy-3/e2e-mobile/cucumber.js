module.exports = {
  default:
    "--publish-quiet --require-module @babel/register --format @cucumber/pretty-formatter --format rerun:@rerun.log --format json:./cucumber-json/cucumber-report.json",
};
