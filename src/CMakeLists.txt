file(GLOB SRCS "*")
add_executable(${PROJECT_NAME} ${SRCS})

# LIST(APPEND LIBS wpcap packet common)
# LIST(APPEND LIBS debug wingetoptd optimized wingetopt)
# TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${LIBS})
