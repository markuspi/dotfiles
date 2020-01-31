#
# Robot Operating System
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_ROS_SHOW="${SPACESHIP_ROS_SHOW=true}"
SPACESHIP_ROS_PREFIX="${SPACESHIP_ROS_PREFIX="with "}"
SPACESHIP_ROS_SUFFIX="${SPACESHIP_ROS_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_ROS_SYMBOL="${SPACESHIP_ROS_SYMBOL=""}"
SPACESHIP_ROS_COLOR="${SPACESHIP_ROS_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show ros environment
spaceship_ros() {
  [[ $SPACESHIP_ROS_SHOW == false ]] && return

  [ -n "$ROS_DISTRO" ] || return

  local ros="$ROS_DISTRO"

  local colons="${ROS_PACKAGE_PATH//[^:]/}"

  [[ "${#colons}" -gt 0 ]] && ros="${ros}+${#colons}"

spaceship::section \
    "$SPACESHIP_ROS_COLOR" \
    "$SPACESHIP_ROS_PREFIX" \
    "${SPACESHIP_ROS_SYMBOL}${ros}" \
    "$SPACESHIP_ROS_SUFFIX"
}
