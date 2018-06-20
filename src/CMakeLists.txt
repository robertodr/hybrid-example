find_package(MPI REQUIRED)

find_package(OpenMP REQUIRED)

add_executable(hybrid-hello hybrid-hello.cpp)

target_link_libraries(hybrid-hello
  PUBLIC
    MPI::MPI_CXX
    OpenMP::OpenMP_CXX
  )

install(
  TARGETS
    hybrid-hello
  DESTINATION
    ${CMAKE_INSTALL_BINDIR}
  )
